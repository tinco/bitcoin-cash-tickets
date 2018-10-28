class TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Ticket.all.map do
      {
        address: ticket.address,
        status: ticket.status,
        paid: ticket.paid,
        price: ticket.price,
        amount: ticket.amount,
        event: ticket.event.name,
        event_id: ticket.event_id,
        user_info: ticket.user_info,
        batch: ticket.batch_id,
        salt: ticket.salt
      }
    end
  end

  # The action for the user to use to view the ticket that was created for them
  def show
    ticket = Ticket.find(params[:address])

    render json: {
      address: ticket.address,
      salt: ticket.salt,
      status: ticket.status,
      event: ticket.event.name,
      event_id: ticket.event_id,
    }
  end

  # Creates a new unpaid ticket for an event
  def create
    event = Event.find(params[:event_id])
    batch = params[:batch_id] # for when an event has multiple types of tickets
    amount = params[:amount] # amount of tickets
    user_info = { anonymous: SecureRandom::hex } # instead of a random string this could have user info
    price = event.price * amount
    address = TicketAddresses.create_ticket_address(event, batch)

    ticket = Ticket.create!(
      event: event,
      batch_id: batch,
      amount: amount,
      price: price,
      user_info: user_info,
      address: address,
      status: :unconfirmed
    )

    render json: {
      address: address,
      salt: ticket.salt,
      price: event.price * amount,
    }
  end

  # Renders ticket status information
  def check
    salt = params[:salt]
    address = params[:address]
    ticket = Ticket.find_by_address(address)
    verified = @ticket.verify(salt)
    paid = TicketAddresses.ticket_address_paid(address)
    status = ticket.status

    render json: {
      verified: verified,
      paid: paid,
      status: status,
    }
  end

  def confirm
    ticket = Ticket.find_by_address(params[:address])
    ticket.update! status: :confirmed
  end
end
