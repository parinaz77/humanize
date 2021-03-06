class IndexController < ApplicationController
  def index
  end

  def dashboard

  end

  def survey
    if params[:type] == 'before'
      @form_id = "before-survey-form"
    elsif params[:type] == 'after'
      @form_id = "after-survey-form"
    else
      # error msg
      render "layouts/404"
    end
  end

  def tips
    if request.xhr?
      render layout: false
    end
  end

  def thankyou

  end

  # controller action to return session info to feed into dashboard main chart
  def sessioninfo
    current_date = params[:current_date]

    prev_session = HumanizeHelper.get_prev_session('Bloopr', current_date)
    prev_session_id = prev_session["id"]
    @q_one_before_avg = HumanizeHelper.avg_before_question('Bloopr', prev_session_id, 1)
    @q_two_before_avg = HumanizeHelper.avg_before_question('Bloopr', prev_session_id, 2)
    @q_three_before_avg = HumanizeHelper.avg_before_question('Bloopr', prev_session_id, 3)
    @q_one_after_avg = HumanizeHelper.avg_after_question('Bloopr', prev_session_id, 1)
    @q_two_after_avg = HumanizeHelper.avg_after_question('Bloopr', prev_session_id, 2)
    @q_three_after_avg = HumanizeHelper.avg_after_question('Bloopr', prev_session_id, 3)

    render partial: 'highchart', locals: {
      q_one_before_avg: @q_one_before_avg,
      q_two_before_avg: @q_two_before_avg,
      q_three_before_avg: @q_three_before_avg,
      q_one_after_avg: @q_one_after_avg,
      q_two_after_avg: @q_two_after_avg,
      q_three_after_avg: @q_three_after_avg
    }
  end

  # controller action to retrieve session title and date to feed into dashboard
  def sessionheader
    current_date = params[:current_date]

    prev_session = HumanizeHelper.get_prev_session('Bloopr', current_date)

    topic = prev_session['topic']
    date = prev_session['date']

    render text: topic + "&" + date
  end

  # controller action to retrieve filtered data to feed into dashboard main chart
  def filterdata
    @q_one_before_avg = HumanizeHelper.avg_before_question('Bloopr', 4, 1, params)
    @q_two_before_avg = HumanizeHelper.avg_before_question('Bloopr', 4, 2, params)
    @q_three_before_avg = HumanizeHelper.avg_before_question('Bloopr', 4, 3, params)
    @q_one_after_avg = HumanizeHelper.avg_after_question('Bloopr', 4, 1, params)
    @q_two_after_avg = HumanizeHelper.avg_after_question('Bloopr', 4, 2, params)
    @q_three_after_avg = HumanizeHelper.avg_after_question('Bloopr', 4, 3, params)

    render partial: 'highchart', locals: {
      q_one_before_avg: @q_one_before_avg,
      q_two_before_avg: @q_two_before_avg,
      q_three_before_avg: @q_three_before_avg,
      q_one_after_avg: @q_one_after_avg,
      q_two_after_avg: @q_two_after_avg,
      q_three_after_avg: @q_three_after_avg
    }
  end
end
