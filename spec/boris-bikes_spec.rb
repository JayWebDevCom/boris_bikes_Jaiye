require 'boris-bikes'

describe DockingStation do

  bike = Bike.new

  it 'Docking station responds to :release_bike' do
    expect(subject).to respond_to :release_bike
  end

  it 'Docking station responds to :release_bike' do
    expect(subject).to respond_to(:dock).with(1).argument
  end

  it 'responds to #bike' do
    expect(subject).to respond_to(:bike)
  end

  it 'No bikes raises error' do
   expect{subject.release_bike}.to raise_error "There are no bikes"
  end

  it "dock will accept more than one bike" do
    subject.dock(Bike.new)
    expect{subject.dock(Bike.new)}.to_not raise_error
  end

  it "check docking station can have bikes" do
    expect(subject.bikes.class).to eq Array
  end

  it "dock can accept more than one bike" do
    subject.dock(Bike.new)
    expect(subject.bikes.count).to eq 1
    subject.dock(Bike.new)
    expect(subject.bikes.count).to eq 2
  end

  it 'dock releases a Bike from capacity' do
    subject.dock(Bike.new)
    expect(subject.bikes.count).to eq 1
    subject.release_bike
    expect(subject.bikes.count).to eq 0
  end

  it "cannot dock a bike if #bikes is at #bikes" do
    newcap = DockingStation::DEFAULT_CAPACITY/2
    newcap.times {subject.dock Bike.new}
    newcap.times {subject.dock Bike.new(false)}
    expect {subject.dock(Bike.new)}.to raise_error "Dock full"
  end

  it "new dock can take an argument for #capacity" do
      ds = DockingStation.new(14)
      expect(ds.capacity).to eq 14
  end

  it "new dock initializes with #DEFAULT_CAPACITY of 20" do
      expect(subject.capacity).to eq 20
  end

  it "check docking station can have broken bikes" do
    expect(subject.broken_bikes.class).to eq Array
  end

  it "working bikes go into #bikes" do
    b = Bike.new()
    subject.dock(b) if b.working
    expect(subject.bikes.count).to eq 1
  end

  it "broken bikes go into #broken_bikes" do
    b = Bike.new(false)
    subject.dock(b) if !b.working
    expect(subject.broken_bikes.count).to eq 1
  end

end
