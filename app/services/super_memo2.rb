class SuperMemo2
  class << self
    def repetition(text, typos, attempt, seconds, repetitions, e_factor)
      quality = find_quality_of_answer(text, attempt, typos, seconds)
      if quality > 2
        new_e_factor = calculate_efactor(e_factor, quality)
        interval = repetition_interval(repetitions, interval, e_factor)
        {
          success: true,
          repetitions: interval,
          review_date: repetitions.days.from_now,
          e_factor: new_e_factor
        }
      else
        {
          success: false,
          repetitions: 1,
          review_date: 1.day.from_now
        }
      end
    end

    def find_quality_of_answer(text, attempt, typos, seconds)
      if typos < text.size / 3.0
        quality = 5 - attempt
        quality = [quality - 1, 3].max if seconds.to_f > 30.0
      else
        quality = [(text.size / typos).floor, 2].min
      end
      quality
    end

    def repetition_interval(repetitions, interval, e_factor)
      return 6 if repetitions == 1
      (interval * e_factor).round
    end

    def calculate_efactor(e_factor, quality)
      e_factor = e_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
      [e_factor, 1.3].max
    end
  end
end
