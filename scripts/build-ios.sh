#!/bin/bash

set -eou pipefail

( cd examples/java-objc/ios && pod install && cd .. && flutter build ios )

( cd examples/kotlin-swift/ios && pod install && cd .. && flutter build ios )
