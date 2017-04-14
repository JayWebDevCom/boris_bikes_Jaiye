require 'docking_station'

describe DockingStation do

  let(:bike) { double :bike }

  it 'responds to #release_bike' do
    expect(subject).to respond_to :release_bike
  end

  it 'responds to #release_bike' do
    expect(subject).to respond_to(:dock).with(1).argument
  end

  it 'responds to #bike' do
    expect(subject).to respond_to(:bike)
  end

  it 'cannot release a bike if there are none' do
   expect{subject.release_bike}.to raise_error "There are no bikes"
  end

  it "accepts bikes" do
    bike = double('bike', :working => true)
    expect{subject.dock(bike)}.to_not raise_error
    expect(subject.bikes.count).to eq 1
  end

  it "can have bikes" do
    expect(subject.bikes.class).to eq Array
  end

  it "can accept more than one bike" do
    bike = double('bike', :working => true)
    subject.dock(bike)
    expect(subject.bikes.count).to eq 1
    subject.dock(bike)
    expect(subject.bikes.count).to eq 2
  end

  it 'releases a Bike from capacity' do
    bike = double('bike', :working => true)
    subject.dock(bike)
    expect(subject.bikes.count).to eq 1
    subject.release_bike
    expect(subject.bikes.count).to eq 0
  end

  it "cannot dock a bike if bikes is at capacity" do
    (DockingStation::DEFAULT_CAPACITY/2).times {subject.dock Bike.new}
    (DockingStation::DEFAULT_CAPACITY/2).times {subject.dock Bike.new(false)}
    expect {subject.dock(bike)}.to raise_error "Dock full"
  end

  it "can take an argument for capacity at initialization" do
      ds = DockingStation.new(14)
      expect(ds.capacity).to eq 14
  end

  it "initializes with #DEFAULT_CAPACITY of 20" do
      expect(subject.capacity).to eq 20
  end

  it "can have broken bikes and working bikes" do
    expect(subject.broken_bikes.class).to eq Array
    expect(subject.bikes.class).to eq Array
  end

  it "puts working bikes into bikes array" do
    bike = double('bike', :working => true)
    subject.dock(bike) if bike.working
    expect(subject.bikes.count).to eq 1
  end

  it "broken bikes go into broken_bikes array" do
    bike = double('bike', :report_broken_bike => false, :working => false)
    bike.report_broken_bike
    subject.dock(bike)
    expect(subject.broken_bikes.count).to eq 1
  end

  it "does not dispense broken bikes" do
    bike = double('bike', :report_broken_bike => false, :working => false)
    bike.report_broken_bike
    subject.dock(bike)
    expect{subject.release_bike}.to raise_error 'There are no working bikes'
  end

end
