RSpec.describe Foobara::LruCache do
  subject(:cache) { described_class.new(capacity) }

  let(:capacity) { 3 }

  describe "#cached" do
    context "when the key is not in the cache" do
      it "adds the key/value to the cache" do
        called = false
        expect {
          expect(cache.cached(:key1) {
            called = true
            "value1"
          }).to eq("value1")
          expect(called).to be true
        }.to change(cache, :size).from(0).to(1)
        expect {
          called = false
          expect(cache.cached(:key1) {
            # :nocov:
            called = true
            "value1"
            # :nocov:
          }).to eq("value1")
          expect(called).to be false
        }.to_not change(cache, :size)
      end
    end

    context "when the cache is full" do
      it "deletes the least recently used item" do
        cache.cached(:key1) { "value1" }
        cache.cached(:key1) { "value1" }
        cache.cached(:key2) { "value2" }
        cache.cached(:key3) { "value3" }
        cache.cached(:key4) { "value4" }
        cache.cached(:key4) { "value4" }
        cache.cached(:key3) { "value4" }
        cache.cached(:key2) { "value4" }
        cache.cached(:key1) { "value4" }
        cache.cached(:key1) { "value1" }
        cache.cached(:key2) { "value2" }
        cache.cached(:key3) { "value3" }
        cache.cached(:key4) { "value4" }
        cache.cached(:key4) { "value4" }

        expect(cache.size).to eq(capacity)
        expect(cache.key?(:key1)).to be false
        expect(cache.key?(:key2)).to be true
        expect(cache.key?(:key3)).to be true
        expect(cache.key?(:key4)).to be true
      end
    end
  end

  it "works with keys other than strings" do
    key = { foo: ["bar"], baz: 100 }
    expect(cache.cached(key) { "yay!" }).to eq("yay!")
    expect(cache.key?(key)).to be true
    expect(cache.size).to eq(1)
    expect(cache.cached(key) { "yay!" }).to eq("yay!")
    expect(cache.key?(key)).to be true
    expect(cache.size).to eq(1)
  end
end
