class Object
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end

  def present?
    !blank?
  end

  class String
    def blank?
      self.gsub(/[[:space:]]+/, '').empty?
    end
  end
end
