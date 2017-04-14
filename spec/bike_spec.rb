require 'bike'

describe Bike do

  it 'it works when new' do
    expect(subject.working).to eq true
  end

  it 'responds to working' do
    expect(subject).to respond_to :working
  end

  it 'responds to #report_broken_bike' do
    expect(subject).to respond_to :report_broken_bike
  end

  it 'can be reported as broken' do
    expect(subject.report_broken_bike).to eq false
  end

end
