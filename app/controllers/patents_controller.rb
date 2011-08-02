class PatentsController < ApplicationController
  def show 
    respond_to do |format|
      format.js {
        @fake = FakePatent.all.sample
        @real = RealPatent.all.sample
        @spin = rand(2)
        @patent_array = @spin == 0 ? [@fake, @real] : [@real, @fake]
        render 'troll_again'
      }
    end
  end

end
