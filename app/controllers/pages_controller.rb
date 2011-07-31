class PagesController < ApplicationController
  def home
    @fake = FakePatent.all.sample
    @real = RealPatent.all.sample
    @patent_array = [@fake, @real].shuffle
  end
end
