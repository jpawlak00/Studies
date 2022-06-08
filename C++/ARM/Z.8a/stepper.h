
class Stepper
{
	public:
		void StepLeft(void);
		void StepRight(void);
	private:
		Led MyLed;
		unsigned char ucLedCtr;
		void Step(enum Step);
};
