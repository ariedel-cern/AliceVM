#!/bin/bash
# File              : vagrant-up.sh
# Author            : Anton Riedel <anton.riedel@tum.de>
# Date              : 19.05.2022
# Last Modified Date: 19.05.2022
# Last Modified By  : Anton Riedel <anton.riedel@tum.de>

# startup scirpt for tmuxp

pushd $HOME/AliceVM
vagrant up
popd

exit 0
