# -*- encoding: utf-8 -*-
# stub: pry-doc 0.4.6 ruby lib

Gem::Specification.new do |s|
  s.name = "pry-doc"
  s.version = "0.4.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["John Mair (banisterfiend)"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDODCCAiCgAwIBAgIBADANBgkqhkiG9w0BAQUFADBCMRQwEgYDVQQDDAtreXJ5\nbG9zaWxpbjEVMBMGCgmSJomT8ixkARkWBWdtYWlsMRMwEQYKCZImiZPyLGQBGRYD\nY29tMB4XDTEzMDMyMTE5MjcwNVoXDTE0MDMyMTE5MjcwNFowQjEUMBIGA1UEAwwL\na3lyeWxvc2lsaW4xFTATBgoJkiaJk/IsZAEZFgVnbWFpbDETMBEGCgmSJomT8ixk\nARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMJbA6oW4xgZ\ndnX19As5Day9emQiVT1ZrQQQMIe0EIg3BvtYKcl17gEUcRKfRN+Aeb1/+PzX7vQj\nXAZioNryWHazkn+Ih8XyY3/CXPe78Hb0TgzyVQJXNP599iNX88Sp1qLSbo+axuUG\nZlDWE/qvyMpEOD11aZK17lJfknomYwUX9YYNNj4rzi3/u+fUnx0k6yNRWeHRC9oA\nXFSg6O+A/HZhE9tlWe8tv8tHOx48tLNERCu2fGU8R/LQ14zgBbJ677AmxzAyoKkE\niraCHgnl2N1NKGgYbkg07+xF1SLVvbMgW0Z3wPedJNQe806NdnFW5WUItRZP4L7p\nxfor6ihKCbkCAwEAAaM5MDcwCQYDVR0TBAIwADAdBgNVHQ4EFgQURXH6bAFa6pDw\nQeyM5vUMaMefiOowCwYDVR0PBAQDAgSwMA0GCSqGSIb3DQEBBQUAA4IBAQBzI5yw\nnjgn7a1/xk9y2abXcOhyJhhVSNhQPUT2Hp8iEbBNHSvGZ27lu71zR+aNqFIGZtNx\nE3pGCQyemcUfJUXq45CpMyZRpIpDiQYS0GcEvE8HgxNSt0wCPni6nMV4JQcOWMBN\nG2qiuXBFr5DpEOLYMsJ98HiaVUFccpyWcl8Lf4P/8CQeTY1YNR2TwOmooZiXjhLf\nQLTxBEEWH8jAiixLsQc58RqJ5ve4aeInKMnVN1hNvDqCI/ttTNepRxr+2K5FTD0d\nWgU0k85lanm1mxaZwCtAWgtppKhbDM2xI74woW7PaGRF4JaeF7kV601CFs7UxVy2\nsooul8M+4MWStBzb\n-----END CERTIFICATE-----\n"]
  s.date = "2013-05-19"
  s.description = "Provides YARD and extended documentation support for Pry"
  s.email = ["jrmair@gmail.com"]
  s.homepage = "https://github.com/pry/pry-doc"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.0"
  s.summary = "Provides YARD and extended documentation support for Pry"

  s.installed_by_version = "2.2.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yard>, [">= 0.8"])
      s.add_runtime_dependency(%q<pry>, [">= 0.9"])
      s.add_development_dependency(%q<latest_ruby>, [">= 0"])
      s.add_development_dependency(%q<bacon>, [">= 1.1.0"])
    else
      s.add_dependency(%q<yard>, [">= 0.8"])
      s.add_dependency(%q<pry>, [">= 0.9"])
      s.add_dependency(%q<latest_ruby>, [">= 0"])
      s.add_dependency(%q<bacon>, [">= 1.1.0"])
    end
  else
    s.add_dependency(%q<yard>, [">= 0.8"])
    s.add_dependency(%q<pry>, [">= 0.9"])
    s.add_dependency(%q<latest_ruby>, [">= 0"])
    s.add_dependency(%q<bacon>, [">= 1.1.0"])
  end
end
