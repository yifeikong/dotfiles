#!/bin/bash

umount /Volumes/touro
mount -t ntfs -o rw,auto,nobrowse /dev/disk2s1 ~/disk1
