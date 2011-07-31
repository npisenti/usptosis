class PagesController < ApplicationController
  def home
    @fake = FakePatent.all.sample
    @real = RealPatent.all.sample
  end
end
