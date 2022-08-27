require 'spec_helper'

describe Window do
    let(:array) { [1,2,3] }
    let(:window) { array.to_w }

    it 'can be created from an array' do
        expect(window).to be_a(Window)
    end

    describe '#[]' do
        it 'can index into the underlying array' do
            expect(window[0]).to eq(1)
            expect(window[1]).to eq(2)
            expect(window[2]).to eq(3)
        end

        it 'keeps a reference to the original array' do
            array[1] = 10
            expect(window[1]).to eq(10)
        end
    end

    describe '#[]=' do
        it 'mutates the underlying array' do
            window[1] = 10
            expect(array[1]).to eq(10)
        end
    end

    describe '#[n, m]' do
        it 're-slices the window' do
            window[1,2][0] = 10
            expect(array[1]).to eq(10)
        end
    end

    describe '#map!' do
        it 'mutates the underlying array' do
            window.map! { _1 + 10 }
            expect(array).to eq([11, 12, 13])
        end
    end
end

describe Vec do
    let(:vec_a) { Vec[1,2] }
    let(:vec_b) { Vec[3,4] }
    it 'should support addition' do
        expect(vec_a + vec_b).to eq(Vec[4,6])
    end
    it 'should support subtraction' do
        expect(vec_a - vec_b).to eq(Vec[-2,-2])
    end

    it 'can do dot products' do
        expect(vec_a.dot vec_b).to eq(11)
    end

    it 'can project vectors' do
        expect(vec_a.project_onto vec_b).to eq(Vec[33,44]/25)
    end
end
