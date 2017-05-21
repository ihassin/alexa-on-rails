class Alexa
  def build
    model = AlexaGenerator::InteractionModel.build do |model|
      model.add_intent(:ListOffice) do |intent|
        intent.add_slot(:Office, AlexaGenerator::Slot::SlotType::LITERAL) do |slot|
          slot.add_bindings(Office.all.pluck(:name))
        end

        intent.add_utterance_template('who works in {Office}')
      end
    end
    model.intent_schema
    model.sample_utterances('ListOffice')
  end
end
