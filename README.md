# TestingNSPinnedDomains
App to test SSL Pinning ([NSPinnedDomains](https://developer.apple.com/documentation/bundleresources/information_property_list/nsapptransportsecurity/nspinneddomains), iOS 14+)

https://user-images.githubusercontent.com/4176826/121184549-0e53a600-c81a-11eb-8ded-1d68e93d5756.mov

## Status 6/8/2021
- Apple [acknowledged bug for WKWebView](https://developer.apple.com/forums/thread/678081)
- The assumption is that, similar to Extensible Enterprise SSO, SSL pinning, based on `NSPinnedDomains`, should work automatically with CFNetwork (`URLSession`, `ASwebAuthenticationSession`, `SFSafariViewController`, `WKWebView`). [Awaiting confirmation](https://developer.apple.com/forums/thread/681734)

## Status 1/26/2022

❌ Issue still remains that not all CFNetwork APIs (e.g. WKWebView and SFSafariViewController) honor iOS certificate pinning.
- Tested with physical device iPhone 8 and iOS 15.2
- Tested with iPhone 11 (iOS 15.2) simulator and Xcode 13.2.1 on macOS 11.6.2## Status 1/26/2022

## Status 1/28/2022

❌ Issue still remains that not all CFNetwork APIs (e.g. WKWebView and SFSafariViewController) honor iOS certificate pinning.
- Tested with physical device iPhone 8 and iOS 15.3

## Background

Nowadays Apple platforms (iOS 14.0+, macOS 11.0+) do provide certificate pinning simply by configuration: https://developer.apple.com/news/?id=g9ejcf8y

## Pinned Domain

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
                            <string>XlCPXC6IrttTF9Y1887kS+efCCf3uFjHW6D1TUI9f+Q=</string>
                        </dict>
                    </array>
                </dict>
            </dict>
        </dict>
```

## SPKI-SHA256-BASE64 generation

You might need to (re-)generate value for `SPKI-SHA256-BASE64` in case certificate changes.

As of 1/26/2022 the certificate details are

```
CONNECTED(00000005)
depth=2 C = IE, O = Baltimore, OU = CyberTrust, CN = Baltimore CyberTrust Root
verify return:1
depth=1 C = US, O = "Cloudflare, Inc.", CN = Cloudflare Inc ECC CA-3
verify return:1
depth=0 C = US, ST = California, L = San Francisco, O = "Cloudflare, Inc.", CN = sni.cloudflaressl.com
verify return:1
---
Certificate chain
 0 s:/C=US/ST=California/L=San Francisco/O=Cloudflare, Inc./CN=sni.cloudflaressl.com
   i:/C=US/O=Cloudflare, Inc./CN=Cloudflare Inc ECC CA-3
-----BEGIN CERTIFICATE-----
MIIFODCCBN6gAwIBAgIQDyp6lxK+XXMFAk57ngzgqjAKBggqhkjOPQQDAjBKMQsw
CQYDVQQGEwJVUzEZMBcGA1UEChMQQ2xvdWRmbGFyZSwgSW5jLjEgMB4GA1UEAxMX
Q2xvdWRmbGFyZSBJbmMgRUNDIENBLTMwHhcNMjEwNjI4MDAwMDAwWhcNMjIwNjI3
MjM1OTU5WjB1MQswCQYDVQQGEwJVUzETMBEGA1UECBMKQ2FsaWZvcm5pYTEWMBQG
A1UEBxMNU2FuIEZyYW5jaXNjbzEZMBcGA1UEChMQQ2xvdWRmbGFyZSwgSW5jLjEe
MBwGA1UEAxMVc25pLmNsb3VkZmxhcmVzc2wuY29tMFkwEwYHKoZIzj0CAQYIKoZI
zj0DAQcDQgAEue3t/MQ9XSvGZMFTo7ZSVnu/4oar/5SX/ZzKETsjLYt0e5R/mQAT
+tEBcwCzkDt08iDXR1PU+DNYpQf1EjmKfqOCA3kwggN1MB8GA1UdIwQYMBaAFKXO
N+rrsHUOlGeItEX62SQQh5YfMB0GA1UdDgQWBBSQanoOPWamtWp3WfVnJhDD8E3p
tzA+BgNVHREENzA1ggx0eXBpY29kZS5jb22CFXNuaS5jbG91ZGZsYXJlc3NsLmNv
bYIOKi50eXBpY29kZS5jb20wDgYDVR0PAQH/BAQDAgeAMB0GA1UdJQQWMBQGCCsG
AQUFBwMBBggrBgEFBQcDAjB7BgNVHR8EdDByMDegNaAzhjFodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vQ2xvdWRmbGFyZUluY0VDQ0NBLTMuY3JsMDegNaAzhjFodHRw
Oi8vY3JsNC5kaWdpY2VydC5jb20vQ2xvdWRmbGFyZUluY0VDQ0NBLTMuY3JsMD4G
A1UdIAQ3MDUwMwYGZ4EMAQICMCkwJwYIKwYBBQUHAgEWG2h0dHA6Ly93d3cuZGln
aWNlcnQuY29tL0NQUzB2BggrBgEFBQcBAQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6
Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0aHR0cDovL2NhY2VydHMu
ZGlnaWNlcnQuY29tL0Nsb3VkZmxhcmVJbmNFQ0NDQS0zLmNydDAMBgNVHRMBAf8E
AjAAMIIBfwYKKwYBBAHWeQIEAgSCAW8EggFrAWkAdgApeb7wnjk5IfBWc59jpXfl
vld9nGAK+PlNXSZcJV3HhAAAAXpTKCpbAAAEAwBHMEUCIHVlgulBqmCzyuw1nmcB
LFSYHTz7Wyo2rfFObgQ/LbUHAiEA/kzrzGimKI/Vw+TQOtSRmDMPyk3N8OIYKAB6
GMcGrNoAdwAiRUUHWVUkVpY/oS/x922G4CMmY63AS39dxoNcbuIPAgAAAXpTKCqf
AAAEAwBIMEYCIQDdHeXhR9xTRXKZI9LFPdiXk2HRfOHqGcEqkAfjRnD22QIhALw/
D9hK8wKkaKzVe0UKWsO57bkBVeR1BLpYS9Pi/+WDAHYAQcjKsd8iRkoQxqE6CUKH
Xk4xixsD6+tLx2jwkGKWBvYAAAF6UygqYAAABAMARzBFAiEAhypm+Quwbn3ASsjy
ZZ0nmuzAhr+qMQE2RXpek4/vzTYCICpsJGPX0OXXq6Pqd9pMSHCfbkp4K+kZCX/N
ziOrAk3EMAoGCCqGSM49BAMCA0gAMEUCIAzzcI29Cey6wEqEhVW/Be9WbsTXVqVr
sDyTSfnPV0E6AiEAp/OJ7BCwZ1rIwZPGZpW7LT5wBs3ttE7FkIGoL83gQN4=
-----END CERTIFICATE-----
 1 s:/C=US/O=Cloudflare, Inc./CN=Cloudflare Inc ECC CA-3
   i:/C=IE/O=Baltimore/OU=CyberTrust/CN=Baltimore CyberTrust Root
-----BEGIN CERTIFICATE-----
MIIDzTCCArWgAwIBAgIQCjeHZF5ftIwiTv0b7RQMPDANBgkqhkiG9w0BAQsFADBa
MQswCQYDVQQGEwJJRTESMBAGA1UEChMJQmFsdGltb3JlMRMwEQYDVQQLEwpDeWJl
clRydXN0MSIwIAYDVQQDExlCYWx0aW1vcmUgQ3liZXJUcnVzdCBSb290MB4XDTIw
MDEyNzEyNDgwOFoXDTI0MTIzMTIzNTk1OVowSjELMAkGA1UEBhMCVVMxGTAXBgNV
BAoTEENsb3VkZmxhcmUsIEluYy4xIDAeBgNVBAMTF0Nsb3VkZmxhcmUgSW5jIEVD
QyBDQS0zMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEua1NZpkUC0bsH4HRKlAe
nQMVLzQSfS2WuIg4m4Vfj7+7Te9hRsTJc9QkT+DuHM5ss1FxL2ruTAUJd9NyYqSb
16OCAWgwggFkMB0GA1UdDgQWBBSlzjfq67B1DpRniLRF+tkkEIeWHzAfBgNVHSME
GDAWgBTlnVkwgkdYzKz6CFQ2hns6tQRN8DAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMBIGA1UdEwEB/wQIMAYBAf8CAQAwNAYI
KwYBBQUHAQEEKDAmMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5j
b20wOgYDVR0fBDMwMTAvoC2gK4YpaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL09t
bmlyb290MjAyNS5jcmwwbQYDVR0gBGYwZDA3BglghkgBhv1sAQEwKjAoBggrBgEF
BQcCARYcaHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzALBglghkgBhv1sAQIw
CAYGZ4EMAQIBMAgGBmeBDAECAjAIBgZngQwBAgMwDQYJKoZIhvcNAQELBQADggEB
AAUkHd0bsCrrmNaF4zlNXmtXnYJX/OvoMaJXkGUFvhZEOFp3ArnPEELG4ZKk40Un
+ABHLGioVplTVI+tnkDB0A+21w0LOEhsUCxJkAZbZB2LzEgwLt4I4ptJIsCSDBFe
lpKU1fwg3FZs5ZKTv3ocwDfjhUkV+ivhdDkYD7fa86JXWGBPzI6UAPxGezQxPk1H
goE6y/SJXQ7vTQ1unBuCJN0yJV0ReFEQPaA1IwQvZW+cwdFD19Ae8zFnWSfda9J1
CZMRJCQUzym+5iPDuI9yP+kHyCREU3qzuWFloUwOxkgAyXVjBYdwRVKD05WdRerw
6DEdfgkfCv4+3ao8XnTSrLE=
-----END CERTIFICATE-----
---
Server certificate
subject=/C=US/ST=California/L=San Francisco/O=Cloudflare, Inc./CN=sni.cloudflaressl.com
issuer=/C=US/O=Cloudflare, Inc./CN=Cloudflare Inc ECC CA-3
---
No client certificate CA names sent
Server Temp Key: ECDH, X25519, 253 bits
---
SSL handshake has read 2766 bytes and written 318 bytes
---
New, TLSv1/SSLv3, Cipher is ECDHE-ECDSA-CHACHA20-POLY1305
Server public key is 256 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-ECDSA-CHACHA20-POLY1305
    Session-ID: 3F057DE207EA6AD18AD8D97549946DA6E9E2CCBE17C1CABD55D04245205FEB4C
    Session-ID-ctx:
    Master-Key: C5FED29FB26FA74F763E7313644183A8AA1EEB508642B57250873E41B008387AD876506D5D61D7BF7F81327F00036AAE
    TLS session ticket lifetime hint: 64799 (seconds)
    TLS session ticket:
    0000 - 4b 59 d6 c4 1f 12 02 2e-a7 30 5f 28 3e 23 eb db   KY.......0_(>#..
    0010 - 45 26 df 52 a4 b3 20 33-2d 49 24 d1 3a a5 29 95   E&.R.. 3-I$.:.).
    0020 - 1e a2 63 0a 84 8c a4 d3-ec 49 f2 fb 52 1c d9 fb   ..c......I..R...
    0030 - bd aa cb 94 03 5c 16 38-08 cd 2e 7e 1b b9 85 e2   .....\.8...~....
    0040 - 5f 8e 1b 98 33 cb 15 d1-c7 f0 71 f5 8b ff d0 97   _...3.....q.....
    0050 - d2 d6 ff 22 aa d5 cb 59-6c fc 1e 62 7a 91 6a 5a   ..."...Yl..bz.jZ
    0060 - 07 9f 87 01 2e 0c 46 80-1e c1 3b 28 a1 d6 a3 cc   ......F...;(....
    0070 - b7 1c 3c 6c 9d 73 12 04-9a de cd 4b d8 c3 b9 1b   ..<l.s.....K....
    0080 - 2c 4d 19 4a 9c 4e a5 29-22 25 53 bc 29 80 b5 8e   ,M.J.N.)"%S.)...
    0090 - 28 54 10 f8 e3 28 82 69-de 1a c8 5b b7 46 5c a0   (T...(.i...[.F\.
    00a0 - fe a4 c3 df f6 31 de 78-d6 c8 4f 39 35 0f 41 70   .....1.x..O95.Ap

    Start Time: 1643220708
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
---
```

which were obtained with

```
openssl s_client -connect jsonplaceholder.typicode.com:443 -servername jsonplaceholder.typicode.com -showcerts
```

Generate SPKI-SHA256-BASE64 in terminal with

```
openssl s_client -showcerts -servername jsonplaceholder.typicode.com -connect jsonplaceholder.typicode.com:443 </dev/null 2>/dev/null|openssl x509 -outform PEM | openssl x509 -inform pem -noout -outform pem -pubkey | openssl pkey -pubin -inform pem -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```
