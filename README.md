ParaDNS
=======

Just got the abandoned lib and fixed some bugs.

  * Nameserver direct access
  * Make ParaDNS compatible with lastest version of Net::DNS
  * Better handle o NXDOMAIN
  * Drop make_query_packet in favor of  Net::DNS::Packet->new

Also added some tests and removed some trash code ( ParaDNS::XS )

[Full Changelog](https://github.com/jcbf/ParaDNS/compare/394720e131f87406c870cafaa617cc2628913f19...HEAD)

