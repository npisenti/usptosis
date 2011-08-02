class PagesController < ApplicationController
  def home
    @fake = FakePatent.all.sample
    @real = RealPatent.all.sample
    @spin = rand(2)
    @patent_array = @spin == 0 ? [@fake, @real] : [@real, @fake]
  end

  def about
  end

  def root
    redirect_to home_path
  end

end
