module Enumerable

  def my_each
    counter = 0
    while counter < self.length do
      if self.class == Hash
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
    while counter < self.length do 
      if self.class == Hash
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
        yield(key, value)
        newHash[key] = value
      end
      return newHash
    elsif self.class == Array
      newArr = []
      self.my_each do |item|
        yield(item)
        newArr.push(item)
      end
      return newArr
    end
  end

  def my_all?
    self.my_each do |item|
      if yield(item) == false then return false end
    end
    return true
  end

  def my_any?
    self.my_each do |item|
      if yield(item) == true then return true end
    end
    return false
  end

end
 