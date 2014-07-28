require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/primedia/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v1.0.1.tar.gz"
  sha1 "28ad08acb47675bedc16e6721e4fc16475df856b"
  head "https://#{PACKAGE}.git"

  depends_on "go" => :build

  def install
    (buildpath + "src/#{PACKAGE}").install "rpenv.go"

    ENV["GOPATH"] = buildpath

    system "go", "build", "-o", "rpenv", PACKAGE
    bin.install "rpenv"
  end

  test do
    `#{bin}/rpenv`
    assert_equal $?.to_i, 1
  end
end
