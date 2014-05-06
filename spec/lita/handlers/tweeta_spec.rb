require "spec_helper"

describe Lita::Handlers::Tweeta, lita_handler: true do
  it { routes_command("hey jimmy https://twitter.com/tristaneuan/status/463007122087616512 check out this tweet").to(:tweeta) }

  describe "#tweeta" do
    it "returns the author and text of a linked tweet" do
      send_command "hey jimmy https://twitter.com/tristaneuan/status/463007122087616512 check out this tweet"
      expect(replies.first).to match "Tristan Chong said: Congratulations on 400 GitHub stars, @litachatbot and @jimmycuadra! #chatops #ruby https://www.lita.io/"
    end
  end
end
