##[

  These are the networking commands usable in the command-line and in menu entries.


  Visit the official GRUB documentation for more information.

  https://www.gnu.org/software/grub/manual/grub/grub.html#Networking-commands
]##

type
  NetCommand * = ref object
    addAddr* : string ## add_addr interface card address
      ## Configure additional network interface with address on a network card.
      ## address can be either IP in dotted decimal notation, or
      ## symbolic name which is resolved using DNS lookup.
      ## If successful, this command also adds local link routing entry to the
      ## default subnet of address with name interface':local' via interface.
    addDns* : seq[string] ## add_dns server
      ## Resolve server IP address and add to the list of DNS servers used during name lookup.
    addRoute* : string ## add_route shortname ip[/prefix] [interface | 'gw' gateway]
      ## Add route to network with address ip as modified by
      ## prefix via either local interface or gateway.
      ## prefix is optional and defaults to 32 for IPv4 address and 128 for IPv6 address.
      ## Route is identified by shortname which can be used to remove it (see del_route).
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#005fdel_005froute
    bootp* : string ## bootp [card]
      ## Alias for dhcp, for compatibility with older Grub versions.
      ## Will perform the same DHCP handshake with
      ## potential fallback to BOOTP as the
      ## dhcp command (see dhcp).
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#005fdhcp
    delAddr* : string ## del_addr interface
      ## Remove configured interface with associated address.
    delDns* : string ## del_dns address
      ## Remove address from list of servers used during name lookup.
    delRoute* : string ## del_route shortname
      ## Remove route entry identified by shortname.
    dhcp* : string ## dhcp [card]
      ## Perform configuration of card using DHCP protocol.
      ## If no card name is specified, try to configure all existing cards.
      ## Falls back to the BOOTP protocol, if needed.
      ## If configuration was successful,
      ## interface with name card':dhcp' and configured address is added to card.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#005fdhcp
    getDhcpOption* : string ## get_dhcp_option var interface number type
      ## Request DHCP option number of type via interface.
      ## type can be one of 'string', 'number' or 'hex'.
      ## If option is found, assign its value to variable var.
      ## Values of types 'number' and 'hex' are converted to string representation.
    ipv6Autoconf* : string ## ipv6_autoconf [card]
      ## Perform IPv6 autoconfiguration by adding to the
      ## card interface with name card':link' and
      ## link local MAC-based address.
      ## If no card is specified, perform autoconfiguration for all existing cards.
    lsAddr* : string ## ls_addr
      ## List all configured interfaces with their MAC and IP addresses.
    lsCards* : string ## ls_cards
      ## List all detected network cards with their MAC address.
    lsDns* : string ## ls_dns
      ## List addresses of DNS servers used during name lookup.
    lsRoutes* : string ## ls_routes
      ## List routing entries.
    nslookup* : string ## nslookup name [server]
      ## Resolve address of name using DNS server server.
      ## If no server is given, use default list of servers.