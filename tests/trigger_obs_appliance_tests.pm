use base "basetest";
use strict;
use testapi;

sub run() {
	assert_script_run("zypper -n --no-gpg-checks ref -s", 400);
	assert_script_run("zypper -n in --force-resolution --no-recommends obs-tests-appliance ruby2.3-devel libxml2-devel libxslt-devel", 300);
	script_run("echo -en \"[client]\nuser = root\npassword = opensuse\n\" > /root/.my.cnf");
	my $script="prove -v /usr/lib/obs/tests/appliance/*.{t,ts} 2>&1 | tee /tmp/appliance_tests.txt", 360;
	validate_script_output $script, sub { m/All tests successful./ };
	save_screenshot;
	upload_logs("/tmp/appliance_tests.txt");
	}

sub test_flags() {
    return {important => 1};
	}

1;
