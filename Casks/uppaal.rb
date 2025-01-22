
cask "uppaal" do
  version "5.0.0"
  sha256 "66dfdbd4b941fbc16a541c4c3962f9768a80a841b4bbe3815d0c31197c0c33ff"

  url "https://download.uppaal.org/uppaal-5.0/uppaal-#{version}/UPPAAL-#{version}-app.zip"
  name "Uppaal"
  desc "Integrated tool environment for modeling, simulation, and verification of real-time systems"
  homepage "https://uppaal.org/"

  livecheck do
    url "https://uppaal.org/downloads/"
    strategy :page_match do |page|
      page.scan(/UPPAAL-(\d+(?:\.\d+)*)-app\.zip/i).map { |match| match[0] }
    end
  end

  depends_on macos: ">= :catalina"
  depends_on formula: "openjdk"

  app "UPPAAL-#{version}.app"

  postflight do
    puts "Please register at veriaal.dk to obtain a free academic license key. See https://uppaal.org/downloads/ for details."
  end

  zap trash: [
    "~/Library/Preferences/org.uppaal.uppaal.plist",
    "~/Library/Saved Application State/org.uppaal.uppaal.savedState"
  ]

  caveats do
    requires_rosetta
  end
end
