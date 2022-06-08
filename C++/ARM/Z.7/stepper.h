
class Stepper
{
	public:
		Stepper(unsigned char = 0);
		void StepLeft(void);
		void StepRight(void);
	private:
		Led MyLed;
		unsigned char ucLedCtr;
		void Step(enum Step);
};
