class SuperMemo2
  # Split the knowledge into smallest possible items.
  # With all items associate an E-Factor equal to 2.5.

  # If the quality response was lower than 3 then start repetitions
  # for the item from the beginning without changing the E-Factor
  # (i.e. use intervals I(1), I(2) etc. as if the item was memorized anew).
  # After each repetition session of a given day repeat again all items
  # that scored below four in the quality assessment. Continue the repetitions
  # until all of these items score at least four.
  def self.repetition(e_factor, interval, quality, repetitions, review_date, seconds)
    repetitions = number_of_repetitions(repetitions, quality)
    {
      e_factor: calculate_efactor(e_factor, quality),
      interval: repetition_interval(repetitions, interval, e_factor).days,
      quality: quality,
      repetitions: repetitions + 1,
      review_date: Time.zone.now + interval
    }
  end

  # Repeat items using the following intervals:
  # I(1):=1
  # I(2):=6
  # for n>2: I(n):=I(n-1)*EF
  # where:
  # I(n) - inter-repetition interval after the n-th repetition (in days),
  # EF - E-Factor of a given item
  # If interval is a fraction, round it up to the nearest integer.
  def self.repetition_interval(repetitions, interval, e_factor)
    case repetitions
    when 0 then 1
    when 1 then 6
    else
      (interval * e_factor).ceil
    end
  end

  # After each repetition modify the E-Factor of the recently repeated
  # item according to the formula:
  # EF':=EF+(0.1-(5-q)*(0.08+(5-q)*0.02))
  # where:
  # EF' - new value of the E-Factor,
  # EF - old value of the E-Factor,
  # q - quality of the response in the 0-5 grade scale.
  # If EF is less than 1.3 then let EF be 1.3.
  def self.calculate_efactor(e_factor, quality)
    e_factor = e_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    [e_factor, 1.3].max
  end

  # Return count repetitions
  def self.number_of_repetitions(repetitions, quality)
    quality < 3 ? 1 : repetitions
  end
end
