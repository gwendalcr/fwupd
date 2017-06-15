#!/bin/bash

dirname=`dirname $0`

# ---
echo "Refreshing with dummy metadata..."
fwupdmgr refresh ${dirname}/firmware-example.xml.gz ${dirname}/firmware-example.xml.gz.asc
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# ---
echo "Update the device hash database..."
fwupdmgr verify-update
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# ---
echo "Getting devices (should be one)..."
fwupdmgr get-devices
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# ---
echo "Testing the verification of firmware..."
fwupdmgr verify
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# ---
echo "Getting updates (should be one)..."
fwupdmgr get-updates
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# ---
echo "Installing test firmware..."
fwupdmgr install ${dirname}/fakedevice124.cab
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# ---
echo "Testing the verification of firmware (again)..."
fwupdmgr verify
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# ---
echo "Refreshing from the LVFS (requires network access)..."
fwupdmgr refresh
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# success!
exit 0
