class Alexa
  def build_intent
    model = AlexaGenerator::InteractionModel.build do |model|
      model.add_intent(:OfficeWorkers) do |intent|
        intent.add_slot(:Office, AlexaGenerator::Slot::SlotType::LITERAL) do |slot|
          slot.add_bindings(Office.all.pluck(:name))
        end

        intent.add_utterance_template('who works in {Office}')
      end
    end
    model.intent_schema
    model.sample_utterances('OfficeWorkers')
  end
end
