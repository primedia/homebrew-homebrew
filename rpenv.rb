require "formula"

class Rpenv < Formula
  homepage "https://github.com/primedia/rpenv"
  url "https://github.com/primedia/rpenv/archive/v1.0.0.tar.gz"
  sha1 "d9a918d3fa49b5527d87aa3e02e2c8b3d1ba0b5c"
  head "https://github.com/primedia/rpenv.git"

  depends_on "go" => :build

  def install
    (buildpath + "src/github.com/primedia/rpenv").install "rpenv.go"

    ENV["GOPATH"] = buildpath

    system "go", "build", "-o", "rpenv"
    bin.install "rpenv"
  end

  test do
    `#{bin}/rpenv`
    assert_equal $?.to_i, 1
  end
end
