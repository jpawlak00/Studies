
class Led
{
	public:
		void StepLeft(void);
		void StepRight(void);
		void Init(void);
	private:
		unsigned char ucLedCtr;
		void Step(enum Step);
		void On(unsigned char);
};
