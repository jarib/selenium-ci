Setup:
======

1. Run `gem install bundler && bundle install`
2. cd to a selenium checkout
3. Use `bin/vagrant-go` to execute crazyfun targets.

This will be pretty slow for the time being since we set up the full VM from scratch on every command.

Examples:

    # run ruby tests with firefox 3
    $ bin/vagrant-go -Xshare=/path/to/selenium/trunk -Xmodules=firefox::v3 //rb:firefox-test

    # run python tests with firefox 7
    $ bin/vagrant-go -Xshare=/path/to/selenium/trunk -Xmodules=firefox::v7,python test_firefox_py

    # run java tests with chrome
    $ bin/vagrant-go -Xshare=/path/to/selenium/trunk -Xmodules=chrome test_chrome

TODO
====

-	use vagrant-snap to do snapshots/rollback.
