require 'spec_helper'

describe Less::Parser do

  cwd = Pathname(__FILE__).dirname

  describe "simple usage" do
    it "parse less into a tree" do
      root = subject.parse(".class {width: 1+1}")
      root.to_css.gsub(/\n/,'').should eql ".class {  width: 2;}"
    end

    it "accepts options when assembling the parse tree" do
      subject.parse(".class {width: 1px+1px;}", :compress => true).to_css.strip.should eql ".class{width:2px}"
    end
  end

  it "throws a ParseError if the lesscss is bogus" do
    -> {subject.parse('{^)').to_css}.should raise_error(Less::ParseError)
  end

  describe "when configured with multiple load paths" do
    before {
      @parser = Less::Parser.new(:paths => [cwd.join('one').to_s, cwd.join('two').to_s])
    }

    it "will load files from both paths" do
      @parser.parse('@import "one.less";').to_css.gsub(/\n/,'').strip.should eql ".one {  width: 1;}"
      @parser.parse('@import "two.less";').to_css.gsub(/\n/,'').strip.should eql ".two {  width: 1;}"
    end
  end

  describe "when load paths are specified in as default options" do
    before do
      Less.paths << cwd.join('one').to_s
      Less.paths << cwd.join('two').to_s
      @parser = Less::Parser.new
    end
    after do
      Less.paths.clear
    end

    it "will load files from default load paths" do
      @parser.parse('@import "one.less";').to_css.gsub(/\n/,'').strip.should eql ".one {  width: 1;}"
      @parser.parse('@import "two.less";').to_css.gsub(/\n/,'').strip.should eql ".two {  width: 1;}"
    end
  end

end
