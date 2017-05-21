class Alexa
  def build_intent_schema
    iface = AlexaGenerator::InteractionModel.build do |iface|
      iface.add_intent('AMAZON.StopIntent')
      iface.add_intent(:ListOffice) do |intent|
        intent.add_utterance_template('list our offices')
        intent.add_utterance_template('list offices')
        intent.add_utterance_template('list the offices')
      end
      iface.add_intent(:Bookit) do |intent|
        intent.add_slot(:StartDate, AlexaGenerator::Slot::SlotType::DATE) do |slot|
          slot.add_binding('StartDate')
        end
        intent.add_slot(:EndDate, AlexaGenerator::Slot::SlotType::DATE) do |slot|
          slot.add_binding('EndDate')
        end
        intent.add_utterance_template('for vacant rooms between {StartDate} and {EndDate}')
        intent.add_utterance_template('to find a room for {StartDate}')
      end
      iface.add_intent(:OfficeQuery) do |intent|
        intent.add_slot(:Office, AlexaGenerator::Slot::SlotType::LITERAL) do |slot|
          slot.add_binding('New York')
          slot.add_binding('London')
        end
        intent.add_utterance_template('if we have an office in {Office}')
      end
    end
    # p iface.intent_schema
    # iface.intents.each do |intent|
    #   p iface.sample_utterances(intent[0])
    # end
  end
end
