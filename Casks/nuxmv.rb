cask "nuxmv" do
  version "2.1.0"
  sha256 "dc0a1710f0ae9f36e16238d40b35dcf66f823d357013bd2e74c09f6e9b9c6dd5"

  url "https://nuxmv.fbk.eu/theme/download.php?file=nuXmv-#{version}-macos-universal.tar.xz",
      verified: "nuxmv.fbk.eu/"
  name "nuXmv"
  desc "A new symbolic model checker for the analysis of synchronous finite-state and infinite-state systems"
  homepage "https://nuxmv.fbk.eu/"

  # Create the wrapper BEFORE Homebrew links binaries.
  preflight do
    # Try to find the extracted directory reliably
    exe_path = Dir["#{staged_path}/*/bin/nuXmv"].first
    raise "nuXmv executable not found under #{staged_path}" unless exe_path

    base_dir = File.dirname(File.dirname(exe_path))
    lib_dir  = File.join(base_dir, "share", "nuxmv")
    shim     = File.join(staged_path, "nuxmv-shim")

    File.write shim, <<~SH
      #!/bin/sh
      export NUXMV_LIBRARY_PATH="#{lib_dir}"
      exec "#{exe_path}" "$@"
    SH
    File.chmod 0755, shim
  end

  # Link the wrapper that now exists (created in preflight)
  binary "#{staged_path}/nuxmv-shim", target: "nuXmv"

  caveats <<~EOS
    • License: nuXmv is provided for non-commercial / academic use only.
      See: https://nuxmv.fbk.eu/license.html

    • A wrapper named 'nuxmv' is installed to set NUXMV_LIBRARY_PATH for you.
      Run: nuxmv -h

    • Examples & docs:
      #{staged_path}/nuXmv-#{version}/examples
      #{staged_path}/nuXmv-#{version}/doc/user-man/nuxmv.pdf
  EOS

  livecheck do
    url "https://nuxmv.fbk.eu/download.html"
    regex(/Version\s+(\d+(?:\.\d+)+).+?Mac\s*OS\s*X:\s*<[^>]*macos-universal/i)
    strategy :page_match
  end
end
