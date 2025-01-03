#pragma once
#include "common/PTString.h"

class UserInfo
{
public:
	int UserID;
	int age;
	ByteString username;
	PTString biography;
	PTString location;
	ByteString website;

	int saveCount;
	float averageScore;
	int highestScore;

	int topicCount;
	int topicReplies;
	int reputation;

	UserInfo(int id, int age, ByteString username, PTString biography, PTString location, ByteString website, int saveCount, float averageScore, int highestScore, int topicCount, int topicReplies, int reputation):
		UserID(id),
		age(age),
		username(username),
		biography(biography),
		location(location),
		website(website),
		saveCount(saveCount),
		averageScore(averageScore),
		highestScore(highestScore),
		topicCount(topicCount),
		topicReplies(topicReplies),
		reputation(reputation)
	{ }
	UserInfo() {}
};
