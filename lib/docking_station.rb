class DockingStation

  attr_accessor  :bikes, :capacity, :broken_bikes, :bike

  DEFAULT_CAPACITY = 20

  def release_bike
      raise "There are no bikes" if empty?

      to_be_released = nil

      bikes.each { |bike|
          to_be_released = bikes.delete(bike) if bike.working
      }

      if to_be_released == nil
          raise 'There are no working bikes'
      else
        to_be_released
      end

  end

  def dock(bike)
    fail "Dock full" if full?
    bike.working ? bikes << bike : broken_bikes << bike
  end

  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
    @broken_bikes = []
  end

private

def full?
  (bikes.count + broken_bikes.count) == capacity ? true : false
end

def empty?
  (bikes.count + broken_bikes.count) == 0 ? true : false
end

end
