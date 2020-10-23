module Enumerable

  def my_each
    counter = 0
    while counter < self.size do
      if self.class == Hash || self.class == Range
          convertedHash = self.to_a
          yield(convertedHash[counter])
          counter += 1
      else
        yield(self[counter])
        counter += 1
      end
    end
  end

  def my_each_with_index
    counter = 0
    while counter < self.size do 
      if self.class == Hash || self.class == Range
          convertedHash = self.to_a
          yield(convertedHash[counter], counter)
          counter += 1
      else
        yield(self[counter], counter)
        counter += 1
      end
    end
  end

  def my_select
    if self.class == Hash 
      newHash = {}
      self.my_each do |key, value|
       if yield(key, value) then newHash[key] = value end
      end
      return newHash
    else
      newArr = []
      self.my_each do |item|
        if yield(item) then newArr.push(item) end
      end
      return newArr
    end
  end

  def my_all?(type = nil)
    if block_given?
      self.my_each do |item|
        if yield(item) == false then return false end
      end
      return true
    else
      if type == nil
        self.my_each do |item| 
          if item == nil or false 
            return false end
        end
        return true
      else
        self.my_each do |item|
          if item.class != type && item.class.superclass != type 
            return false end
        end
        return true 
      end 
    end
  end

  def my_any?(type = nil)
    if block_given?
      self.my_each do |item|
        if yield(item) == true then return true end
      end
      return false
    else
      if type == nil
        self.my_each do |item| 
          if item != nil or false 
            return true end
        end
        return false
      else
        self.my_each do |item|
          if item.class == type or item.class.superclass == type
            return true end
        end
        return false 
      end 
    end
  end

  def my_none?(type = nil)
    if block_given?
      self.my_each do |item|
        if yield(item) == true then return false end
      end
      return true
    else
      if type == nil
        self.my_each do |item| 
          if item != nil && item != false 
            return false end
        end
        return true
      else
        self.my_each do |item|
          if item.class == type or item.class.superclass == type or item.is_a? type
            return false end
        end
        return true 
      end 
    end
  end


  def my_count(num = nil)
    counter = 0 
    if block_given?
      self.my_each do |item|
        if yield(item) == true then counter += 1 end
      end
      return counter
    else
      if num == nil
        self.my_each do |item| 
          counter += 1 
        end
        return counter
      else
        self.my_each do |item|
          if item == num then counter += 1 end
        end
        return counter
      end
    end
  end

  def my_map
    tempArr = []
    self.my_each do |item|
      unless yield(item) == false
        tempArr.push(yield(item))
      end
    end
    return tempArr
  end

  def my_inject(accum = nil, sym = nil)
    num = nil
    self.my_each do |item|
      if block_given?
        accum = accum.nil? ? item : yield(accum, item)
      else
        if accum.is_a? Numeric
          accum = accum.send(sym, item)
        elsif accum.is_a? Symbol
          num = num.nil? ? item : num.send(accum, item)
        end
      end
    end
    unless num != nil then return accum else return num end
  end

end

def multiply_els(arr)
  return arr.my_inject {|multiply, item| multiply * item }
end

