# TestingNSPinnedDomains
App to test SSL Pinning ([NSPinnedDomains](https://developer.apple.com/documentation/bundleresources/information_property_list/nsapptransportsecurity/nspinneddomains), iOS 14+)

https://user-images.githubusercontent.com/4176826/121184549-0e53a600-c81a-11eb-8ded-1d68e93d5756.mov

`Info.plist`

```xml
        <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSAllowsArbitraryLoads</key>
            <false/>
            <key>NSPinnedDomains</key>
            <dict>
                <key>jsonplaceholder.typicode.com</key>
                <dict>
                    <key>NSIncludesSubdomains</key>
                    <true/>
                    <key>NSPinnedLeafIdentities</key>
                    <array>
                        <dict>
                            <key>SPKI-SHA256-BASE64</key>
                            <string>frajXjTbS+rTizBNs0tFkpyy0eEv/Ar4+7HtsFRL5ow=</string>
                        </dict>
                    </array>
                </dict>
            </dict>
        </dict>
```

## Status 6/8/2021
- Apple [acknowledged bug for WKWebView](https://developer.apple.com/forums/thread/678081)
- The assumption is that, similar to Extensible Enterprise SSO, SSL pinning, based on `NSPinnedDomains`, should work automatically with CFNetwork (`URLSession`, `ASwebAuthenticationSession`, `SFSafariViewController`, `WKWebView`). [Awaiting confirmation](https://developer.apple.com/forums/thread/681734)

## Background

Nowadays Apple platforms (iOS 14.0+, macOS 11.0+) do provide certificate pinning simply by configuration: https://developer.apple.com/news/?id=g9ejcf8y

