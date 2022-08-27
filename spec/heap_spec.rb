require './lib/heap'

describe Heap do
    let(:h1) { Heap::Min[1,4,2,3,5] }
    it 'works 1' do
        expect(h1.drain).to eq([1,2,3,4,5])
    end

    let(:h2) { Heap::Min[5,4,3,2,1] }
    it 'works 2' do
        expect(h2.drain).to eq([1,2,3,4,5])
    end
end
