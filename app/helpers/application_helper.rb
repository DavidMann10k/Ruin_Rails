module ApplicationHelper
  include ActionView::Helpers::DateHelper
  def logo
    RR::Application::GLOBAL_TITLE
  end
  
  def title
    if @title.nil?
      RR::Application::GLOBAL_TITLE
    else
      "#{RR::Application::GLOBAL_TITLE}/#{@title}"
    end
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def translate_time(time)
    if (time >= 12)
      "#{time - 12} pm"
    else
      if (time == 0)
        "12 am"
      else
        "#{time} am"
      end
    end
  end
  
end

module ActionView
  module Helpers
    module DateHelper
      def select_hour(datetime, options = {})
        val = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.hour) : ''
        if options[:use_hidden]
          hidden_html(options[:field_name] || 'hour', val, options)
        else
          hour_options = []
          0.upto(23) do |hour|
            unit = hour < 12 ? :am : :pm
            selected = "selected='selected'" if val == hour
            value = leading_zero_on_single_digits hour
            hr = leading_zero_on_single_digits( unit == :am ? hour : (hour - 12) )
            hr = '12' if hr == '00'
            hour_options << %(<option value="#{ value }" #{ selected }>#{ hr }#{ unit }</option>\n)
          end
          select_html(options[:field_name] || 'hour', hour_options, options)
        end
      end
    end
  end
end
