#!/bin/bash

set -eou pipefail

( cd examples/java-objc && flutter build apk )

( cd examples/kotlin-swift && flutter build apk )
