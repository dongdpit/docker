#!/bin/bash

sleep 5

du -ah / | sort -hr | head -20
