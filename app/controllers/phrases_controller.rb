class PhrasesController < ApplicationController
  def new
    @phrase = Phrase.new
  end

  def create
    @phrase = Phrase.new(phrase_params)
    old_phrase = @phrase.old_string
    array = grammify(old_phrase)
    @phrase.new_string = array[-1]
    @phrase.old_string = array[0]
    if @phrase.save
      redirect_to phrase_path(@phrase)
    else
      render new
    end
  end

  def show
    set_phrase
  end

  private

  def phrase_params
    params.require(:phrase).permit(:old_string)
  end

  def set_phrase
    @phrase = Phrase.find(params[:id])
  end

  def grammify(phrase)
    phrase += " "
    process = []
    process << phrase
    phrase.upcase!
    phrase.gsub!(',', ' ,')
    phrase.gsub!(/\WNR\W/,'Near ')
    phrase.gsub!(/\WOP\W/,'Opposite ')
    phrase.gsub!(/\WOPP\W/,'Opposite ')
    phrase.gsub!(/\WTE\W/,'Tehsil ')
    phrase.gsub!(/\WBH\W/,'Behind ')
    phrase.gsub!(/\WRD/,'Road ')
    phrase.gsub!('BYE PASS', 'Bypass')
    phrase.gsub!('BYEPASS', 'Bypass')
    phrase.gsub!('(', ' (')
    phrase.gsub!(')', ') ')
    phrase.gsub!(';', ':')
    phrase.gsub!('MIDC', 'M. I. D. C.')
    phrase.gsub!('GIDC', 'G. I. D. C.')
    5.times do
      phrase.gsub!(' -', '-')
      phrase.gsub!('- ', '-')
      phrase.gsub!(' :', ':')
      phrase.gsub!(' .', '.')
      phrase.gsub!('( ', '(')
      phrase.gsub!(' )', ')')
      phrase.gsub!(' /', '/')
      phrase.gsub!('/ ', '/')
    end
    # At the end
    phrase.gsub!(':', ': ')
    phrase.gsub!('.', '. ')
    phrase.gsub!(' ,', ',')
    phrase.gsub!(',', ', ')
    10.times do
      if phrase[-1] =~ /\W/
        phrase = phrase[0..(phrase.length - 2)]
      end
    end
    process << phrase.titlecase
    return process
  end

end
