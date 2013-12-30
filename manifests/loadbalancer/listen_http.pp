#
# Copyright (C) 2013 eNovance SAS <licensing@enovance.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# Define::
#
# privatecloud::loadbalancer::listen_http
#
define privatecloud::loadbalancer::listen_http( $ports = 'unset' ) {
  if $name == '6082' { # spice doesn't support OPTIONS
    $httpchk = 'httpchk GET /'
  } else {
    $httpchk = 'httpchk'
  }

  haproxy::listen { $name:
    ipaddress => '0.0.0.0',
    ports     => $ports,
    options   => {
      'mode'        => 'http',
      'balance'     => 'roundrobin',
      'option'      => ['tcpka', 'tcplog', $httpchk],
      'http-check'  => 'expect ! rstatus ^5',
    }
  }
}