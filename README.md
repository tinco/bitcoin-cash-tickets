BTC Cash Ticketing
============

Flow:

  - Organizer creates event
  - Organizer adds tickets
  - Visitor buys ticket
  - Visitor shows ticket
  - Organizer scans ticket

Backend
-----

Flow:
  - Generate ticket addresses
  - Generate ticket purchase associated with an address for a visitor
  - Listen for payment to addresses, register and then notify visitor
  - Scan visitor ticket, verify registered and not yet visited
