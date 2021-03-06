# frozen_string_literal: true
require "linters/base/options"
require "linters/stylelint/tokenizer"

module Linters
  module Stylelint
    class Options < Linters::Base::Options
      def command
        path = File.join(File.dirname(__FILE__), "../../..")
        cmd = "/node_modules/stylelint/bin/stylelint.js #{filepath}"
        "NODE_PATH=#{path}/node_modules #{File.join(path, cmd)}"
      end

      def config_filename
        ".stylelintrc.json"
      end

      def tokenizer
        Tokenizer.new
      end

      def config_content
        if JSON.parse(config).any?
          config
        else
          combined_config.to_json
        end
      end

      private

      def default_config_path
        "config/.stylelintrc.json"
      end
    end
  end
end
