class SuperMemo2
  class << self
    def repetition(e_factor, interval, typos, repetitions, attempt, seconds)
      quality = set_quality(attempt, typos, seconds)
      e_factor = calculate_efactor(e_factor, quality)
      repetitions = quality < 3 ? 1 : repetitions
      interval = repetition_interval(repetitions, interval, e_factor)
      {
        e_factor: e_factor,
        interval: interval,
        quality: quality,
        repetitions: repetitions
      }
    end

    def quality_helper(attempt, seconds, subtrahend)
      total = 8 * attempt + seconds
      if total < 16
        5 - subtrahend
      elsif total < 24
        4 - subtrahend
      else
        3 - subtrahend
      end
    end

    def set_quality(attempt, typos, seconds)
      if typos < 3
        quality_helper(attempt, seconds, 0)
      else
        quality_helper(attempt, seconds, 3)
      end
    end

    def repetition_interval(repetitions, interval, e_factor)
      case repetitions
      when 0 then 1
      when 1 then 6
      else
        (interval * e_factor).ceil
      end
    end

    def calculate_efactor(e_factor, quality)
      e_factor = e_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
      [e_factor, 1.3].max
    end
  end
end
