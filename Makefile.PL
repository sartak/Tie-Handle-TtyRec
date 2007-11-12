# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name           'Tie-Handle-TtyRec';
all_from       'lib/Tie/Handle/TtyRec.pm';

requires       '';

build_requires 'Test::More';

auto_install;
WriteAll;

