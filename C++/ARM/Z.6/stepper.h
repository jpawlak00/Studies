
class Stepper : Led
{
	public:
		Stepper(unsigned char = 0);
		void StepLeft(void);
		void StepRight(void);
	private:
		unsigned char ucLedCtr;
		void Step(enum Step);
};
