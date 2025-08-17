module States
  extend ActiveSupport::Concern

  included do
    aasm column: "state" do
      state :scheduled, initial: true
      state :verified
      state :developed
      state :delivered
      state :rejected

      event :verify do
        transitions from: :scheduled, to: :verified
      end

      event :develop do
        transitions from: :verified, to: :developed
      end

      event :reject do
        transitions from: :verified, to: :rejected
      end

      event :deliver do
        transitions from: :developed, to: :delivered
      end

      event :unverify do
        transitions from: :verified, to: :scheduled
      end

      event :undevelop do
        transitions from: :developed, to: :verified
      end

      event :unreject do
        transitions from: :rejected, to: :verified
      end

      event :undeliver do
        transitions from: :delivered, to: :developed
      end
    end
  end
end
