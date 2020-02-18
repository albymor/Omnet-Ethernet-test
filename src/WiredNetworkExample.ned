//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package ethernet_test;

import inet.node.inet.*;
import inet.node.ethernet.*;
import inet.node.wireless.*;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
//
// TODO auto-generated type
//
network WiredNetworkExample
{
    parameters:
        int numClients; // number of clients in the network
        @display("bgb=558,315");
    submodules:
        configurator: Ipv4NetworkConfigurator;
        server: StandardHost;
        router: Router { // predefined router
            @display("p=240,43");
        }
        switch: EtherSwitch { // predefined ethernet switch
            @display("p=368,84");
        }
        client[numClients]: StandardHost {
            @display("p=428,184");
        }
    connections: // network level connections
        router.pppg++ <--> {  datarate = 1E9bps; } <--> server.pppg++; // PPP
        switch.ethg++ <--> Eth1G <--> router.ethg++; // bidirectional ethernet
        for i=0..numClients-1 {
            client[i].ethg++ <--> Eth1G <--> switch.ethg++; // ethernet
        }
}
