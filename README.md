ParaDNS
=======

Just got the abandoned lib and fixed some bugs.

  * Namerserver direct access 
  * Better handle o NXDOMAIN
  * Drop make_query_packet in favor of  Net::DNS::Packet->new

Also added some tests and removed some trash code ( ParaDNS::XS )

