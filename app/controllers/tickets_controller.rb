class TicketsController < ApplicationController
  # The action for the user to use to view the ticket that was created for them
  def show
    ticket = Ticket.find(params[:id])

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
    user_info = { anonymous: SecureRandom::hex } # instead of a random string this could have user info

    address = TicketAddresses.create_ticket_address(event, batch)

    ticket = Ticket.create!(
      event: event,
      batch: batch,
      user_info: user_info,
      address: address,
      status: :unconfirmed
    )

    render json: {
      address: address,
      salt: ticket.salt
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
